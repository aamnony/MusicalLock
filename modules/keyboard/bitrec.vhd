library ieee;
use ieee.std_logic_1164.all;
-- simplified 5 states bitrec 
-- Dudy Bar On, lab 1 Dept of EE
-- Copyright  technion IIT  2016 

entity bitrec is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    kb_clk: in std_logic;
    kb_serial_data: in std_logic;
    valid_data: out std_logic;
    key_code: out std_logic_vector(7 downto 0) 
);
end entity;

architecture arc_bitrec of bitrec is
    type state is
    (
        Idle, --initial state
        HighClk,
        LowClk,
        CheckData,
        ValidData
    );
    constant numOfBits: integer := 11;
    signal shift_reg: std_logic_vector(9 downto 0);
    signal parity_ok: std_logic;
begin
    parity_ok <= shift_reg(8) xor shift_reg(7) xor shift_reg(6) xor
                 shift_reg(5) xor shift_reg(4) xor shift_reg(3) xor 
                 shift_reg(2) xor shift_reg(1) xor shift_reg(0);
                
process (clk, resetN)
    variable present_state : state;
    variable count : integer range 0 to 15;
begin
    if resetN = '0' then
        valid_data <= '0';
        count := 0 ;
        present_state := Idle;
    elsif rising_edge (clk) then
        valid_data <= '0';
        key_code <= shift_reg(7 downto 0);
        case present_state is
            when Idle =>
                count := 0;
                if kb_serial_data = '0' and kb_clk = '0' then
                    present_state := LowClk;
                end if;
            when LowClk =>
                if kb_clk = '1' then
                    count := count + 1;
                    shift_reg <= kb_serial_data & shift_reg(9 downto 1);
                    if count < numOfBits then
                        present_state := HighClk;
                    elsif count = numOfBits then
                        present_state := CheckData;
                    end if;
                end if;
            when HighClk =>
                if kb_clk = '0' then    
                    present_state := LowClk;
                end if;
            when CheckData =>
                if parity_ok = '1' then 
                    present_state := ValidData;
                elsif parity_ok = '0' then
                    present_state := Idle;
                end if;
            when ValidData =>
                valid_data <= '1';
                present_state := Idle;
        end case;
    end if;
end process;
end architecture;