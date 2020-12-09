library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all; 

entity MainSPI is
port (
    clk : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR (3 downto 0);
    btnL : in std_logic;
    reset_n : in std_logic;
    btnD : in std_logic;
    spi_bit : out std_logic
    );
end MainSPI;

architecture Behavioral of MainSPI is
    signal packet_1: std_logic_vector(7 downto 0);
    signal packet_2: std_logic_vector(7 downto 0);
    signal counter : integer := 0;
    signal check : std_logic_vector(1 downto 0) := "11";
begin
    packet_1(3 downto 0) <= "0001";
    packet_1(7 downto 4) <= sw(3 downto 0);
    packet_2(3 downto 0) <= "0010";
    packet_2(7 downto 4) <= sw(3 downto 0);
process (clk)
begin
    if falling_edge(clk) then
        if btnD = '1' then
            if check(0) = '1' then
                spi_bit <= packet_1(counter);
                case counter is 
                    when 7 => counter <= 0;
                    when others => counter <= counter+1;
                end case;
            else 
                 
            end if;
        elsif (reset_n = '1' and btnL = '1') then
            spi_bit <= packet_2(counter);
            case counter is 
                when 7 => counter <= 0;
                when others => counter <= counter+1;
            end case;
        end if;   
    end if;
end process;
end Behavioral;