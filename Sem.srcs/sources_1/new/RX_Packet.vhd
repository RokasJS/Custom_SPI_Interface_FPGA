library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all; 

entity RX_Packet is
    Port ( 
        clk : in STD_LOGIC;
        btnD : in STD_LOGIC;
        reset_n : in STD_LOGIC;
        btnL : in STD_LOGIC;
        sw : in std_logic_vector (3 downto 0);
        led : out std_logic_vector(11 downto 0);
        JAA : in std_logic_vector(1 downto 0);
        RX_Dataa : out std_logic_vector(7 downto 0)
        );
end RX_Packet;

architecture Behavioral of RX_Packet is

    signal spi_bit_RX : std_logic;

    signal counter_RX : integer := 0;

    signal RX_Data : std_logic_vector(15 downto 0) := "0000000000000000";


    signal spi_clock_RX : std_logic := '1';
    
begin

process(clk) 
begin
    -- Kol niekas nenuspausta, nieko ir nelaukti
    if rising_edge(clk) then
        if (btnD = '0' and btnL = '0' and reset_n = '0') then
            counter_RX <= 0;
            --RX_Data(7 downto 0) <= "00000000";
        end if;
    end if;
    -- Kai pakyla spi clock frontas laukti duomenu
    if rising_edge(spi_clock_RX) then
        if btnD = '1' then      -- Jei nuspaustas tik btnD laukti atsakymo i pirma komanda
            RX_Data(counter_RX) <= spi_bit_RX;
            if counter_RX = 7 then 
                counter_RX <= 0;
                if(RX_Data (7 downto 4) = sw (3 downto 0)) then -- Tikrinamas adresas
                    RX_Dataa(3 downto 0) <= RX_Data(3 downto 0); -- Gauti duomenys
                else
                    RX_Dataa(3 downto 0) <= "0000";  -- Jei blogas adresas rodoma nuliai
                end if;
            else
                counter_RX <= counter_RX+1; -- Postumio skaitiklio inkrementavimas
            end if;
            
         elsif (reset_n = '1' and btnL = '1') then  -- Jei kiti abu mygtukai tada antros komandos atsakymas
            RX_Data(counter_RX) <= spi_bit_RX;
            if counter_RX = 15 and (RX_Data (15 downto 0) /= "0000000000000000") then 
                counter_RX <= 0;
                if(RX_Data (15 downto 12) = sw (3 downto 0)) then -- Tikrinamas adresas
                -- Uzdegami LED'ai atitinkantis Slave irenginio switchus
                    led(11 downto 0) <= RX_Data(11 downto 0);   
                else
                    led(11 downto 0) <= "000000000000";
                end if;
            elsif RX_Data (15 downto 0) = "0000000000000000" then 
                counter_RX <= 0;
            else
                counter_RX <= counter_RX+1; -- Postumio skaitiklio inkrementavimas
            end if;
        end if;
    end if;
end process;
-- SPI jungtys

spi_clock_RX <= JAA(0); --CLK_IN
spi_bit_RX <= JAA(1);   --MISO

end Behavioral;
