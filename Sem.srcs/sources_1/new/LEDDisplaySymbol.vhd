library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LEDDisplaySymbol is
    Port ( Value : in STD_LOGIC_VECTOR (3 downto 0);
           Segments : out STD_LOGIC_VECTOR (6 downto 0));
end LEDDisplaySymbol;

architecture Behavioral of LEDDisplaySymbol is

begin

with Value(3 downto 0) select
    Segments <=
    "0000001" when x"0" ,
    "1001111" when x"1" ,
    "0010010" when x"2" ,
    "0000110" when x"3" ,
    "1001100" when x"4" ,
    "0100100" when x"5" ,
    "0100000" when x"6" ,
    "0001111" when x"7" ,
    "0000000" when x"8" ,
    "0000100" when x"9" ,
    "0111000" when others;

end Behavioral;
