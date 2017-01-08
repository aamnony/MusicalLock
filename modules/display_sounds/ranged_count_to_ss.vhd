library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.utils.all;

entity ranged_count_to_ss is
port
(
    count: in ranged_count;
    ss_ones: out std_logic_vector(6 downto 0);
    ss_tens: out std_logic_vector(6 downto 0);
    ss_sign: out std_logic_vector(6 downto 0) -- only show minus
);
end entity;

architecture arc_ranged_count_to_ss of ranged_count_to_ss is
    type ss_type is array(0 to 50) of std_logic_vector(13 downto 0);
	constant UNSIGNED_SS: ss_type := 
	(
		"0000001" & "0000001",
		"0000001" & "1001111",
        "0000001" & "0010010",
        "0000001" & "0000110",
        "0000001" & "1001100",
        "0000001" & "0100100",
        "0000001" & "0100000",
        "0000001" & "0001111",
        "0000001" & "0000000",
        "0000001" & "0000100",
        "1001111" & "0000001",
        "1001111" & "1001111",
        "1001111" & "0010010",
        "1001111" & "0000110",
        "1001111" & "1001100",
        "1001111" & "0100100",
        "1001111" & "0100000",
        "1001111" & "0001111",
        "1001111" & "0000000",
        "1001111" & "0000100",
        "0010010" & "0000001",
        "0010010" & "1001111",
        "0010010" & "0010010",
        "0010010" & "0000110",
        "0010010" & "1001100",
        "0010010" & "0100100",
        "0010010" & "0100000",
        "0010010" & "0001111",
        "0010010" & "0000000",
        "0010010" & "0000100",
        "0000110" & "0000001",
        "0000110" & "1001111",
        "0000110" & "0010010",
        "0000110" & "0000110",
        "0000110" & "1001100",
        "0000110" & "0100100",
        "0000110" & "0100000",
        "0000110" & "0001111",
        "0000110" & "0000000",
        "0000110" & "0000100",
        "1001100" & "0000001",
        "1001100" & "1001111",
        "1001100" & "0010010",
        "1001100" & "0000110",
        "1001100" & "1001100",
        "1001100" & "0100100",
        "1001100" & "0100000",
        "1001100" & "0001111",
        "1001100" & "0000000",
        "1001100" & "0000100",
        "0100100" & "0000001"
	);
    signal tens_and_ones_ss: std_logic_vector(13 downto 0);
begin
    tens_and_ones_ss <= UNSIGNED_SS(abs(count));
    
	ss_ones <= tens_and_ones_ss(6 downto 0);
	ss_tens <= tens_and_ones_ss(13 downto 7);
	
	-- 7 segment is active low:
	ss_sign(6 downto 1) <= ( others => '1' );
	ss_sign(0) <= '0' when count < 0 else '1';
end architecture;