library ieee;
use ieee.std_logic_1164.all;

entity display_msg is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    success: in std_logic;
    failure: in std_logic;
    lcd_enable: out std_logic;
    lcd_bus: out std_logic_vector(7 downto 0);
    busy: out std_logic := '1';
    rw, rs, e, pwr, bkpwr: out std_logic;
    lcd_data: out std_logic_vector(7 downto 0)
);
end entity;

architecture arc_display_msg of display_msg is

component LCD is
port
(
    reset_n: in std_logic;
    clk: in std_logic;
    lcd_enable: in std_logic;
    lcd_bus: in std_logic_vector(7 downto 0);
    busy: out std_logic;
    rw, rs, e, pwr, bkpwr: out std_logic;
    lcd_data: out std_logic_vector(7 downto 0)
);
end component;

component str2lcd is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    str: in string(1 to 5); --LCD has 2 lines with 16 characters
    lcd_enable: out std_logic;
    lcd_bus: out std_logic_vector(7 downto 0)
);
end component;

signal str: string(1 to 5);
signal lcd_enable_i: std_logic;
signal lcd_bus_i: std_logic_vector(7 downto 0);

begin
    p: str2lcd port map (resetN, clk, str, lcd_enable_i, lcd_bus_i);
    q: LCD port map (resetN, clk, lcd_enable_i, lcd_bus_i, busy, rw, rs, e, pwr, bkpwr, lcd_data);
    
    str <= "YMCA!" when success = '1' else
           "NO_NO" when failure = '1' else ( others => '0' );
end architecture;