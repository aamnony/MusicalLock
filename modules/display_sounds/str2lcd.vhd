library ieee;
use ieee.std_logic_1164.all;
use work.utils.all;

entity str2lcd is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    enable: in std_logic;
    str: in string(1 to 32); --LCD has 2 lines with 16 characters
    lcd_bus: out std_logic_vector(7 downto 0)
);
end entity;

architecture arc_str2lcd of str2lcd is
begin
process (clk, resetN)
    variable index: integer range 1 to 32 := 1;
begin
    if resetN ='0' then
        lcd_bus <= ( others => '0' );
        index := 1;
    elsif rising_edge(clk) then
        if enable = '1' then
            lcd_bus <= char2lcd(str(index));
            index := index + 1;
        end if;
    end if;
end process;
end architecture;