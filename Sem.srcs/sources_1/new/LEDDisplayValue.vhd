library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LEDDisplayValue is
    Port ( Clk : in STD_LOGIC;
           Value : in STD_LOGIC_VECTOR (7 downto 0);
           Segments : out STD_LOGIC_VECTOR (6 downto 0);
           anodes : out STD_LOGIC_VECTOR (3 downto 0));
end LEDDisplayValue;

architecture Behavioral of LEDDisplayValue is

signal cnt: STD_LOGIC_VECTOR (31 downto 0):= X"00000000";
signal SegmentsValue : STD_LOGIC_VECTOR (3 downto 0):=X"0";
signal Vall : std_logic_vector (7 downto 0);

 component LEDDisplaySymbol
 port (
    Value : in STD_LOGIC_VECTOR (3 downto 0);
    Segments : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

begin

 
 LED_SYMBOL : LEDDisplaySymbol
 port map (
    Value => SegmentsValue,
    Segments => Segments);
process (Clk)
begin
 if (Clk'event and Clk = '1') then
    case Value is
        when "00001010" => Vall <= "00010000";
        when "00001011" => Vall <= "00010001";
        when "00001100" => Vall <= "00010010";
        when "00001101" => Vall <= "00010011";
        when "00001110" => Vall <= "00010100";
        when "00001111" => Vall <= "00010101";
        when others => Vall <= Value;
     end case;
 if Cnt=X"00001000" then
    Cnt<=Cnt+1;
    SegmentsValue<=Vall(3 downto 0);
    anodes <= "1110";
 elsif Cnt=X"00002000" then
    Cnt<=X"00000000";
    SegmentsValue<=Vall(7 downto 4);
    anodes <= "1101";
 else
    Cnt<=Cnt+1;
 end if;
end if;
end process;
end Behavioral;

