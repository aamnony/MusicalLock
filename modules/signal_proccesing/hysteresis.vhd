library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

-- all calculations are done in si (signed integer) format
entity hysteresis is
generic 
(
    THRESHOLD_MAX: integer range -128 to 127 := 64;
    THRESHOLD_MIN: integer range -128 to 127 := -64
);
port
(
    resetN: in std_logic;
    clk: in std_logic;
    input: in std_logic_vector(7 downto 0);
    output: out std_logic
);
end entity;

architecture arc_hysteresis of hysteresis is
    signal curr_output: std_logic := '0';
    signal prev_output: std_logic := '0';
begin
    output <= curr_output;
process (clk, resetN)
begin
    if resetN = '0' then
        curr_output <= '0';
        prev_output <= '0';
    elsif rising_edge(clk) then
        if input <= THRESHOLD_MIN then
                curr_output <= '0';
            elsif input >= THRESHOLD_MAX then
                curr_output <= '1';
            else
                curr_output <= prev_output;
            end if;            
            prev_output <= curr_output;
    end if;
end process;
end architecture;
