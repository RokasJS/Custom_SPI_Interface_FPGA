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
-- vartotojo iterptas tekstas (pradžia)
signal cnt: STD_LOGIC_VECTOR (31 downto 0):= X"00000000";
signal SegmentsValue : STD_LOGIC_VECTOR (3 downto 0):=X"0";
-- Komponentø deklaravimas
 component LEDDisplaySymbol
 port (
 Value : in STD_LOGIC_VECTOR (3 downto 0);
 Segments : out STD_LOGIC_VECTOR (6 downto 0));
end component;
-- vartotojo iterptas tekstas (pabaiga)
begin
-- vartotojo iterptas tekstas (pradžia)
-- Komponentø egzemplioriø kûrimas
 LED_SYMBOL : LEDDisplaySymbol
 port map (
 Value => SegmentsValue,
 Segments => Segments);
process (Clk)
begin
 if (Clk'event and Clk = '1') then
 if Cnt=X"00001000" then
 Cnt<=Cnt+1;
SegmentsValue<=Value(3 downto 0);
 anodes <= "1110";
elsif Cnt=X"00002000" then
 Cnt<=X"00000000";
SegmentsValue<=Value(7 downto 4);
 anodes <= "1101";
else
 Cnt<=Cnt+1;
end if;
 end if;
end process;
-- vartotojo iterptas tekstas (pabaiga)
end Behavioral;

