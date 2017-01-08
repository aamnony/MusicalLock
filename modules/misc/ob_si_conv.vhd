library ieee;
use ieee.std_logic_1164.all;
use work.utils.all;

entity ob_si_conv is
port
(   
    ob_in: in std_logic_vector(7 downto 0);
    si_in: in std_logic_vector(7 downto 0);
    ob_out: out std_logic_vector(7 downto 0);
    si_out: out std_logic_vector(7 downto 0)
);
end entity;

architecture arc_ob_si_conv of ob_si_conv is
begin
    ob_out <= si2ob(si_in);
    si_out <= ob2si(ob_in);
end architecture;