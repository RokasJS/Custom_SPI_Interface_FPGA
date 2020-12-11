library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all; 

entity Clock_Divider is
    Port ( clk : in STD_LOGIC;
           spi_clock : out STD_LOGIC);
end Clock_Divider;

architecture Behavioral of Clock_Divider is
constant Period: integer := 50; -- 1 MHz daliklis
signal delay :STD_LOGIC_VECTOR (31 downto 0) :=X"00000000";
signal div_clk : std_logic := '1';
begin

process(clk)
begin
    if (clk'event and clk = '1') then
        if delay=CONV_STD_LOGIC_VECTOR(Period,32) then
            delay<=X"00000000";
            div_clk <= not div_clk;
            spi_clock <= div_clk;
        else
            delay <= delay + 1;
        end if;
     end if;
end process;

end Behavioral;
