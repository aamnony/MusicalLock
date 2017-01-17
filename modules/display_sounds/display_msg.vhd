library ieee;
use ieee.std_logic_1164.all;
use work.utils.all;

entity display_msg is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    success: in std_logic;
    failure: in std_logic;
    which_password_index: in integer range 0 to 99;
    index_in_password: in integer range 1 to 99;
    enable: in std_logic;
    busy: out std_logic := '1';
    rw, rs, e, pwr, bkpwr: out std_logic;
    lcd_data: out std_logic_vector(7 downto 0)
);
end entity;

architecture arc_display_msg of display_msg is
    type str_arr is array(0 to 99) of string(1 to 2);
    constant IDX2STR: str_arr := 
    (
        "0 ", "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ",
        "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
        "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
        "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
        "40", "41", "42", "43", "44", "45", "46", "47", "48", "49",
        "50", "51", "52", "53", "54", "55", "56", "57", "58", "59",
        "60", "61", "62", "63", "64", "65", "66", "67", "68", "69",
        "70", "71", "72", "73", "74", "75", "76", "77", "78", "79",
        "80", "81", "82", "83", "84", "85", "86", "87", "88", "89",
        "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"
    );

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
        enable: in std_logic;
        str: in string(1 to 32); --LCD has 2 lines with 16 characters
        lcd_bus: out std_logic_vector(7 downto 0)
    );
    end component;

    signal str: string(1 to 32);
    signal lcd_bus_i: std_logic_vector(7 downto 0);

begin
    p: str2lcd port map (resetN, clk, enable, str, lcd_bus_i);
    q: LCD port map (resetN, clk, enable, lcd_bus_i,
                     busy, rw, rs, e, pwr, bkpwr, lcd_data);

    str <= "  Welcome  back " &
           "  to   door  #" & IDX2STR(which_password_index)
           when success = '1' else
           "  You  shall    " &
           "  not pass!     "
           when failure = '1' else
           "  Waiting for   " &
           "  1st sound     "
           when which_password_index = 0 else
           "  Password   #" & IDX2STR(which_password_index) &
           "  Element    #" & IDX2STR(index_in_password)
           ;
end architecture;