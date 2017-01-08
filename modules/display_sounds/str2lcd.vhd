library ieee;
use ieee.std_logic_1164.all;
use work.utils.all;

entity str2lcd is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    str: in string(1 to 5); --LCD has 2 lines with 16 characters
    lcd_enable: out std_logic;
    lcd_bus: out std_logic_vector(7 downto 0)
);
end entity;

architecture arc_str2lcd of str2lcd is
begin
process (clk, resetN)
    variable index: integer range 1 to 33 := 1;
begin
    if resetN ='0' then
        lcd_enable <= '0';
        lcd_bus <= ( others => '0' );
        index := 1;
    elsif rising_edge(clk) then
        if index = 6 then
            lcd_enable <= '0';
            lcd_bus <= ( others => '0' );
        else
            lcd_enable <= '1';
            lcd_bus <= char2lcd(str(index));
            index := index + 1;
        end if;
    end if;
end process;
end architecture;