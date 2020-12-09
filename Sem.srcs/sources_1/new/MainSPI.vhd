library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all; 

entity MainSPI is
port (
    clk : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR (15 downto 0);
    reset_n : in STD_LOGIC;
    segment: out STD_LOGIC_VECTOR (6 downto 0);
    led : out STD_LOGIC_VECTOR (15 downto 0);
    anodes : out STD_LOGIC_VECTOR (3 downto 0)
    );
end MainSPI;
architecture Behavioral of MainSPI is

constant Period: integer := 25000000;
signal Count :STD_LOGIC_VECTOR (7 downto 0) :=X"00";
signal delay :STD_LOGIC_VECTOR (31 downto 0) :=X"00000000";  

component LEDDisplayValue
port (
    Clk : in STD_LOGIC;
    Value : in STD_LOGIC_VECTOR (7 downto 0);
    Segments : out STD_LOGIC_VECTOR (6 downto 0);
    anodes : out STD_LOGIC_VECTOR (3 downto 0));
end component;

begin

led <= sw;

LED_DISPLAY : LEDDisplayValue
port map (
    Clk => clk,
    Value => Count,
    Segments => segment,
    anodes => anodes
    );
    
process (reset_n,clk)
begin
    if reset_n='1' then
        delay<=X"00000000";
    elsif (clk'event and clk = '1') then
        if delay=CONV_STD_LOGIC_VECTOR(Period,32) then 
            delay<=X"00000000";
        else
            delay<=delay+1;
        end if;
    end if;
end process;
end Behavioral;