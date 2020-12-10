library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all; 

entity TX_Packet is
    Port ( spi_clock : in STD_LOGIC;
           btnD : in STD_LOGIC;
           reset_n : in STD_LOGIC;
           btnL : in STD_LOGIC;
           sw : in std_logic_vector (3 downto 0);
           JA : out std_logic_vector (1 downto 0));
end TX_Packet;

architecture Behavioral of TX_Packet is
    constant Period_2: integer := 1000000; -- Vienos sekundes periodas
    signal delay_2 :STD_LOGIC_VECTOR (31 downto 0) :=X"00000000";
    signal spi_bit : std_logic;
    signal packet_1: std_logic_vector(7 downto 0);
    signal packet_2: std_logic_vector(7 downto 0);
    signal counter : integer := 0;
    signal check : std_logic := '0';
    signal allow : std_logic := '0';
    
begin
    packet_1(3 downto 0) <= "0001";
    packet_1(7 downto 4) <= sw(3 downto 0);
    packet_2(3 downto 0) <= "0010";
    packet_2(7 downto 4) <= sw(3 downto 0);
--    packet_1(7 downto 0) <= sw (15 downto 8); -- testinis
process (spi_clock)
begin
    if falling_edge(spi_clock) then
    -- Pirmos komandos siuntimas, 
        if btnD = '1' then
            allow <= '1';
            spi_bit <= packet_1(counter);
            case counter is 
                when 7 => counter <= 0;
                when others => counter <= counter+1; -- Postumio skaitiklio inkrementavimas
            end case; 
        -- Antros komandos siuntimas
        elsif (reset_n = '1' and btnL = '1') then
            if check = '1' then -- Tikrinama ar praejo sekunde
                allow <= '1';
                spi_bit <= packet_2(counter);
                if counter = 7 then
                    counter <= 0;
                    check <= '0';
                else
                    counter <= counter + 1; -- Postumio skaitiklio inkrementavimas 
                end if;
            end if;
        else
            spi_bit <= '0';
            counter <= 0;
            allow <= '0';
        end if;
        -- Siuntimas antro paketo kas sekunde
        if (reset_n = '1' and btnL = '1') then
            if delay_2=CONV_STD_LOGIC_VECTOR(Period_2,32) then
                delay_2<=X"00000000"; 
                check <= '1';        
            else
                delay_2<=delay_2+1;
            end if;
        end if;
    end if;
end process;
-- SPI jungtys
JA(0) <= spi_bit; -- MOSI
JA(1) <= spi_clock nand allow; --CLK_OUT
end Behavioral;
