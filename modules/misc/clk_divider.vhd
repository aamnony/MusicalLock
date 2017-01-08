library ieee;
use ieee.std_logic_1164.all;

entity clk_divider is
generic 
(
    DIV: integer range 0 to 50000000 := 5
);
port
(
    resetN: in std_logic;
    clk: in std_logic;
    divided_clk: out std_logic
);
end entity;

architecture arc_clk_divider of clk_divider is
    signal divided_clk_i: std_logic;
begin
    divided_clk <= divided_clk_i;
process (clk, resetN)
    variable count: integer range 0 to 50000000;
begin
    if resetN = '0' then
        count := DIV;
    elsif rising_edge(clk) then
        if count >= DIV then
            count := 0;
            divided_clk_i <= '1';
        else
            count := count + 1;
            divided_clk_i <= '0';
        end if;
    end if;
end process;
end architecture;
