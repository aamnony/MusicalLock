library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use work.utils.all;

entity sound_detector is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    enable: in std_logic;
    ob: in std_logic_vector(7 downto 0);
    abs_sine: out std_logic_vector(7 downto 0);
    sound: out std_logic
);
end entity;

architecture arc_sound_detector of sound_detector is
    component non_inverting_hysteresis is
    generic 
    (
        OUT_MAX: integer range -128 to 127;
        OUT_MIN: integer range -128 to 127;
        THRESHOLD_MAX: integer range -128 to 127;
        THRESHOLD_MIN: integer range -128 to 127
    );
    port
    (
        clk: in std_logic;
        resetN: in std_logic;
        enable: in std_logic;
        input: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0)
    );
    end component;
    signal nih_out: std_logic_vector(7 downto 0);
    signal absu: std_logic_vector(7 downto 0);
begin
    nih: non_inverting_hysteresis
    generic map
    (
        OUT_MAX => 1,
        OUT_MIN => 0,
        THRESHOLD_MAX => 15,
        THRESHOLD_MIN => 5
    )
    port map
    (
        clk => clk,
        resetN => resetN,
        enable => enable,
        input => absu,
        output => nih_out
    );
    
    sound <= nih_out(0);
    absu <= abs(ob2si(ob));
    abs_sine <= absu;
end architecture;
