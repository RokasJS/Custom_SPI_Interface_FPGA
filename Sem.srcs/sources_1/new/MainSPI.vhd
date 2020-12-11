-- Duomenu siuntimo ir priemimo sasaja, paremta dalinai SPI 
-- Rokas Janavicius EEI-7/3
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all; 

entity MainSPI is
port (
    clk : in STD_LOGIC;
    segment: out STD_LOGIC_VECTOR (6 downto 0);
    led : out STD_LOGIC_VECTOR (15 downto 0);
    JA : out std_logic_vector (1 downto 0); -- TX MOSI / CLK
    JAA : in std_logic_vector (1 downto 0); -- RX MISO / CLK
    sw : in STD_LOGIC_VECTOR (15 downto 0);
    btnL : in std_logic;
    reset_n : in std_logic;
    btnD : in std_logic;
    anodes : out STD_LOGIC_VECTOR (3 downto 0)
    );
end MainSPI;

architecture Behavioral of MainSPI is
    signal RX_Dataa : std_logic_vector(7 downto 0) := "00000000";
    signal spi_clock : std_logic := '1';
       
    -- LED segmentu indikatoriaus komponentas
    component LEDDisplayValue
     port (
        Clk : in STD_LOGIC;
        Value : in STD_LOGIC_VECTOR (7 downto 0);
        Segments : out STD_LOGIC_VECTOR (6 downto 0);
        anodes : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    -- Daznio daliklio komponentas (50MHz i 1 MHz)
    component Clock_Divider
     port (
        clk : in std_logic;
        spi_clock : inout std_logic
     );
    end component;
    
    -- Duomenu siuntimo komponentas
    component TX_Packet 
    port ( spi_clock : in STD_LOGIC;
           btnD : in STD_LOGIC;
           reset_n : in STD_LOGIC;
           btnL : in STD_LOGIC;
           sw : in std_logic_vector (3 downto 0);
           JA : out std_logic_vector (1 downto 0));
    end component;
    
    -- Duomenu priemimo komponentas
    component RX_Packet is
    port ( 
        clk : in STD_LOGIC;
        btnD : in STD_LOGIC;
        reset_n : in STD_LOGIC;
        btnL : in STD_LOGIC;
        sw : in std_logic_vector (3 downto 0);
        led : out std_logic_vector(11 downto 0);
        JAA : in std_logic_vector(1 downto 0);
        RX_Dataa : out std_logic_vector(7 downto 0)
        );
    end component;
    
begin

    LED_DISPLAY : LEDDisplayValue
     port map (
        Clk => clk,
        Value => RX_Dataa,
        Segments => segment,
        anodes => anodes);
    
    Clock_Divide : Clock_Divider
     port map (
        clk => clk,
        spi_clock => spi_clock);
        
     TX_Data : TX_Packet
      port map (
        spi_clock => spi_clock,
        btnD => btnD,
        reset_n => reset_n,
        btnL => btnL,
        sw(3 downto 0) => sw(3 downto 0),
        JA(1 downto 0) => JA(1 downto 0)
        );  
        
      RX_Dat : RX_Packet
       port map (
        clk => clk,
        btnD => btnD,
        reset_n => reset_n,
        btnL => btnL,
        sw(3 downto 0) => sw(3 downto 0),
        led(11 downto 0) => led(11 downto 0),
        JAA(1 downto 0) => JAA(1 downto 0),
        RX_Dataa => RX_Dataa
        );

end Behavioral;