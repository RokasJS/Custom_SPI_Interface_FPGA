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
    spi_bit : inout std_logic;
    spi_clock : inout std_logic;
    spi_bit_RX : inout std_logic;
    RX_Data : inout std_logic_vector(7 downto 0)
    );
end MainSPI;

architecture Behavioral of MainSPI is
    signal packet_1: std_logic_vector(7 downto 0);
    signal packet_2: std_logic_vector(7 downto 0);
    signal counter : integer := 0;
    signal counter_RX : integer := 0;
    signal counter_RXX : integer := 0;
    signal check : std_logic := '1';
    signal RX_Dataa : std_logic_vector(7 downto 0) := "00000000";
    signal RX_Counter : integer := 0;
begin
    packet_1(3 downto 0) <= "0001";
    packet_1(7 downto 4) <= sw(3 downto 0);
    packet_2(3 downto 0) <= "0010";
    packet_2(7 downto 4) <= sw(3 downto 0);
    
process (clk)
begin
    if falling_edge(clk) then
        if btnD = '1' then
            spi_bit <= packet_1(counter);
            case counter is 
                when 7 => counter <= 0;
                when others => counter <= counter+1;
            end case; 
        elsif (reset_n = '1' and btnL = '1') then
            spi_bit <= packet_2(counter);
            case counter is 
                when 7 => counter <= 0;
                when others => counter <= counter+1;
            end case;
        else
            spi_bit <= '0';
            spi_clock <= '1';
            counter <= 0;
        end if;   
    end if;
    if (btnD = '1' or (btnL = '1' and reset_n = '1')) then
        spi_clock <= clk;
    end if;
end process;

process(clk,spi_clock) 
begin
    if rising_edge(clk) then
        if (btnD = '0' and btnL = '0' and reset_n = '0') then
            counter_RX <= 0;
            RX_Dataa(7 downto 0) <= "00000000";
        end if;
    end if;
    if rising_edge(spi_clock) then
        if (btnD = '1' or (btnL = '1' and reset_n = '1')) then
        RX_Dataa(counter_RX) <= spi_bit_RX;
        case counter_RX is 
            when 7 => counter_RX <= 0;
            when others => counter_RX <= counter_RX+1;
        end case;
        end if;
    end if;
end process;
spi_bit_RX <= spi_bit;
RX_Data(7 downto 0) <= RX_Dataa(7 downto 0);
end Behavioral;