library ieee;
use ieee.std_logic_1164.all;

entity tb_MainSPI is
end tb_MainSPI;

architecture tb of tb_MainSPI is

    component MainSPI
        port (clk     : in std_logic;
              sw      : in std_logic_vector (3 downto 0);
              btnL    : in std_logic;
              reset_n : in std_logic;
              btnD    : in std_logic;
              spi_bit : inout std_logic;
              spi_clock : inout std_logic;
              spi_bit_RX : inout std_logic;
              RX_Data : inout std_logic_vector(7 downto 0));
    end component;

    signal clk     : std_logic;
    signal sw      : std_logic_vector (3 downto 0);
    signal btnL    : std_logic;
    signal reset_n : std_logic;
    signal btnD    : std_logic;
    signal spi_bit : std_logic;
    signal spi_clock : std_logic;
    signal spi_bit_RX : std_logic;
    signal RX_Data : std_logic_vector(7 downto 0);
begin

    dut : MainSPI
    port map (clk     => clk,
              sw      => sw,
              btnL    => btnL,
              reset_n => reset_n,
              btnD    => btnD,
              spi_clock => spi_clock,
              spi_bit => spi_bit,
              spi_bit_RX => spi_bit_RX,
              RX_Data => RX_Data);

    stimuli : process
    
    begin
        -- EDIT Adapt initialization as needed
        clk <= '1';
        sw <= "1101";
        btnL <= '0';
        reset_n <= '0';
        btnD <= '0';
        --spi_bit_RX <= '0';
        
        -- EDIT Add stimuli here
        for i in 0 to 100 loop
       
        if i = 6 then
            btnD <= '1';
        end if;
        if i = 25 then
            btnD <= '0';
        end if;
        if i = 30 then
            reset_n <= '1';
            btnL <= '1';
        end if; 
        if i = 63 then
            reset_n <= '1';
            btnL <= '0';
        end if; 
        wait for 10 ns; 
        clk <= not clk; 
        end loop;   
        
        wait;
    end process;

end tb;