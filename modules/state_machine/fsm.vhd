library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use work.utils.all;

entity fsm is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    valid: in std_logic;
    count: in ranged_count;
    success: out std_logic;
    failure: out std_logic
);
end entity;

architecture arc_fsm of fsm is
    constant PASSWORD: ranged_count_array(0 to 2) :=
    (
        30, -40, 30
    );
    
    type state_type is (reset, idle, check_data, failure_state, success_state);
    
    signal curr_state: state_type := reset;

    signal p: integer := 0;
begin

process (clk, resetN)
begin
    if resetN = '0' then
        curr_state <= reset;
        p <= 0;
    elsif rising_edge(clk) then
        case curr_state is
            when reset =>
                success <= '0';
                failure <= '0';
                if valid = '1' then
                    curr_state <= idle;
                else
                    curr_state <= reset;
                end if;
            when idle =>
                success <= '0';
                failure <= '0';
                if valid = '1' then
                    curr_state <= check_data;
                else
                    curr_state <= idle;
                end if;
            when check_data =>
                success <= '0';
                failure <= '0';
                --if (count = PASSWORD(p)) or (count<0) then
                if (count > PASSWORD(p)-10) and (count < PASSWORD(p)+10) then
                    if p = PASSWORD'length - 1 then
                    --if p=1 then
                        curr_state <= success_state;
                    else
                        curr_state <= idle;
                        p <= p + 1;
                    end if;
                else
                    curr_state <= failure_state;
                end if;
            when failure_state =>
                success <= '0';
                failure <= '1';
                curr_state <= failure_state;
            when success_state =>
                success <= '1';
                failure <= '0';
                curr_state <= success_state;
            end case;
    end if;
end process;

end architecture;
