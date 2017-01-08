library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.utils.all;

entity sine_table is
port
(
    clk: in std_logic;
    resetN: in std_logic;
    enable: in std_logic;
    unsigned_x: in std_logic_vector(7 downto 0);
    si_ob: in std_logic; -- output format
    sinx: out std_logic_vector(7 downto 0)
);
end entity;

architecture arc_sine_table of sine_table is
    type vector_array is array (0 to 255) of std_logic_vector(7 downto 0);
	constant SINE_VALUES: vector_array := 
    (
        X"00",    X"03",    X"06",    X"09",    X"0C",    X"0F",    X"12",
        X"15",    X"18",    X"1B",    X"1E",    X"21",    X"24",    X"27",
        X"2A",    X"2D",    X"30",    X"33",    X"36",    X"39",    X"3B",
        X"3E",    X"41",    X"43",    X"46",    X"49",    X"4B",    X"4E",
        X"50",    X"52",    X"55",    X"57",    X"59",    X"5B",    X"5E",
        X"60",    X"62",    X"64",    X"66",    X"67",    X"69",    X"6B",
        X"6C",    X"6E",    X"70",    X"71",    X"72",    X"74",    X"75",
        X"76",    X"77",    X"78",    X"79",    X"7A",    X"7B",    X"7B",
        X"7C",    X"7D",    X"7D",    X"7E",    X"7E",    X"7E",    X"7E",
        X"7E",    X"7F",    X"7E",    X"7E",    X"7E",    X"7E",    X"7E",
        X"7D",    X"7D",    X"7C",    X"7B",    X"7B",    X"7A",    X"79",
        X"78",    X"77",    X"76",    X"75",    X"74",    X"72",    X"71",
        X"70",    X"6E",    X"6C",    X"6B",    X"69",    X"67",    X"66",
        X"64",    X"62",    X"60",    X"5E",    X"5B",    X"59",    X"57",
        X"55",    X"52",    X"50",    X"4E",    X"4B",    X"49",    X"46",
        X"43",    X"41",    X"3E",    X"3B",    X"39",    X"36",    X"33",
        X"30",    X"2D",    X"2A",    X"27",    X"24",    X"21",    X"1E",
        X"1B",    X"18",    X"15",    X"12",    X"0F",    X"0C",    X"09",
        X"06",    X"03",    X"00",    X"FD",    X"FA",    X"F7",    X"F4",
        X"F1",    X"EE",    X"EB",    X"E8",    X"E5",    X"E2",    X"DF",
        X"DC",    X"D9",    X"D6",    X"D3",    X"D0",    X"CD",    X"CA",
        X"C7",    X"C5",    X"C2",    X"BF",    X"BD",    X"BA",    X"B7",
        X"B5",    X"B2",    X"B0",    X"AE",    X"AB",    X"A9",    X"A7",
        X"A5",    X"A2",    X"A0",    X"9E",    X"9C",    X"9A",    X"99",
        X"97",    X"95",    X"94",    X"92",    X"90",    X"8F",    X"8E",
        X"8C",    X"8B",    X"8A",    X"89",    X"88",    X"87",    X"86",
        X"85",    X"85",    X"84",    X"83",    X"83",    X"82",    X"82",
        X"82",    X"82",    X"82",    X"81",    X"82",    X"82",    X"82",
        X"82",    X"82",    X"83",    X"83",    X"84",    X"85",    X"85",
        X"86",    X"87",    X"88",    X"89",    X"8A",    X"8B",    X"8C",
        X"8E",    X"8F",    X"90",    X"92",    X"94",    X"95",    X"97",
        X"99",    X"9A",    X"9C",    X"9E",    X"A0",    X"A2",    X"A5",
        X"A7",    X"A9",    X"AB",    X"AE",    X"B0",    X"B2",    X"B5",
        X"B7",    X"BA",    X"BD",    X"BF",    X"C2",    X"C5",    X"C7",
        X"CA",    X"CD",    X"D0",    X"D3",    X"D6",    X"D9",    X"DC",
        X"DF",    X"E2",    X"E5",    X"E8",    X"EB",    X"EE",    X"F1",
        X"F4",    X"F7",    X"FA",    X"FD"    
    );
begin
process (clk, resetN)
begin
	if resetN = '0' then
		sinx <= SINE_VALUES(0);
	elsif rising_edge(clk) then
		if enable = '1' then
			if si_ob = '1' then
				sinx <= SINE_VALUES(to_integer(unsigned(unsigned_x)));
			else
				sinx <= si2ob(SINE_VALUES(to_integer(unsigned(unsigned_x))));
			end if;
        else
            if si_ob = '1' then
				sinx <= SINE_VALUES(0);
			else
				sinx <= si2ob(SINE_VALUES(0));
			end if;
		end if;
	end if;
end process;
end architecture;