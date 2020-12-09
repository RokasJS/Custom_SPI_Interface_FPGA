library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all; 

entity MainSPI is
port (
    clk : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR (3 downto 0)
    
    );
end MainSPI;
architecture Behavioral of MainSPI is
    signal packet_1 :std_logic_vector(7 downto 0) := "00000001";
    signal packet_2 :std_logic_vector(7 downto 0) := "00000010";
begin
    packet_1(7 downto 4) <= sw(3 downto 0);
    packet_2(7 downto 4) <= sw(3 downto 0);
process (clk)
begin
    if (clk'event and clk = '1') then
        
    end if;
end process;
end Behavioral;