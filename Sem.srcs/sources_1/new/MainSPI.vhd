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
    JA : out std_logic_vector (7 downto 0); 
    sw : in STD_LOGIC_VECTOR (3 downto 0);
    btnL : in std_logic;
    reset_n : in std_logic;
    btnD : in std_logic
    
--    
--    spi_bit_RX : inout std_logic;
--    RX_Data : inout std_logic_vector(7 downto 0)
    );
end MainSPI;

architecture Behavioral of MainSPI is
    constant Period: integer := 50000; 
    constant Period_2: integer := 50000000; 
    signal delay :STD_LOGIC_VECTOR (31 downto 0) :=X"00000000";
    signal delay_2 :STD_LOGIC_VECTOR (31 downto 0) :=X"00000000";
    signal spi_bit : std_logic;
    signal packet_1: std_logic_vector(7 downto 0);
    signal packet_2: std_logic_vector(7 downto 0);
    signal counter : integer := 0;
    signal counter_RX : integer := 0;
    signal counter_RXX : integer := 0;
    signal check : std_logic := '0';
    signal RX_Dataa : std_logic_vector(7 downto 0) := "00000000";
    signal RX_Counter : integer := 0;
    signal spi_clock : std_logic := '1';
begin
    packet_1(3 downto 0) <= "0001";
    packet_1(7 downto 4) <= sw(3 downto 0);
    packet_2(3 downto 0) <= "0010";
    packet_2(7 downto 4) <= sw(3 downto 0);
    
process (clk)
begin
    if falling_edge(clk) then
        if delay=CONV_STD_LOGIC_VECTOR(Period,32) then
            delay<=X"00000000";
            if btnD = '1' then
                spi_clock <= not spi_clock;
                spi_bit <= packet_1(counter);
                case counter is 
                    when 7 => counter <= 0;
                    when others => counter <= counter+1;
                end case; 
            elsif (reset_n = '1' and btnL = '1') then
                if check = '1' then
                    spi_clock <= not spi_clock;
                    spi_bit <= packet_2(counter);
                    if counter = 7 then
                        counter <= 0;
                        check <= '0';
                    else
                        counter <= counter + 1;
                    end if;
                end if;
            else
                spi_bit <= '0';
                spi_clock <= '1';
                counter <= 0;
            end if;
        else
            delay <= delay + 1;
        end if;
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

--process(clk,spi_clock) 
--begin
--    if rising_edge(clk) then
--        if (btnD = '0' and btnL = '0' and reset_n = '0') then
--            counter_RX <= 0;
--            RX_Dataa(7 downto 0) <= "00000000";
--        end if;
--    end if;
--    if rising_edge(spi_clock) then
--        if (btnD = '1' or (btnL = '1' and reset_n = '1')) then
--        RX_Dataa(counter_RX) <= spi_bit_RX;
--        case counter_RX is 
--            when 7 => counter_RX <= 0;
--            when others => counter_RX <= counter_RX+1;
--        end case;
--        end if;
--    end if;
--end process;
JA(0) <= spi_bit;
JA(1) <= spi_clock;
JA(2) <= clk;
--spi_bit_RX <= spi_bit;
--RX_Data(7 downto 0) <= RX_Dataa(7 downto 0);
end Behavioral;