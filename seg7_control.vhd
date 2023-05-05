----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 12:16:07 PM
-- Design Name: 
-- Module Name: seg7_control - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seg7_control is
    Port (  clk : in std_logic; 
            reset : in std_logic;
            ones : in std_logic_vector (3 downto 0);
            digit  : out std_logic;
            seg : out std_logic_vector (6 downto 0)
            );
end seg7_control;

architecture Behavioral of seg7_control is
constant ZERO   : std_logic_vector(6 downto 0) := "0111111"; -- 0
constant ONE    : std_logic_vector(6 downto 0) := "0000110"; -- 1
constant TWO    : std_logic_vector(6 downto 0) := "1011011"; -- 2
constant THREE  : std_logic_vector(6 downto 0) := "1001111"; -- 3
constant FOUR   : std_logic_vector(6 downto 0) := "1100110"; -- 4
constant FIVE   : std_logic_vector(6 downto 0) := "1101101"; -- 5
constant SIX    : std_logic_vector(6 downto 0) := "1111101"; -- 6
constant SEVEN  : std_logic_vector(6 downto 0) := "0000111"; -- 7
constant EIGHT  : std_logic_vector(6 downto 0) := "1111111"; -- 8
constant NINE   : std_logic_vector(6 downto 0) := "1101111"; -- 9

signal digit_select : std_logic := '0'; 
signal digit_timer : std_logic_vector(3 downto 0) := (others => '0') ; 

begin
process(clk, reset)
begin
    if (reset = '1') then
        digit_select <= '0';
        digit_timer <= (others=>'0'); 
    elsif (rising_edge(clk)) then      -- 1ms x 4 displays = 4ms refresh period
        if (unsigned (digit_timer) = 9) then        -- The period of 100MHz clock is 10ns (1/100,000,000 seconds)
            digit_timer <=  (others=>'0');               -- 10ns x 100,000 = 1ms
            
        else
            digit_timer <= std_logic_vector (unsigned ( digit_timer) + 1);
        end if;
    end if;
end process;




process (digit_select, ones)
begin
    case digit_select is
       when '0' => 
            case ones is
                when "0000" => seg <= ZERO;
                when "0001" => seg <= ONE;
                when "0010" => seg <= TWO;
                when "0011" => seg <= THREE;
                when "0100" => seg <= FOUR;
                when "0101" => seg <= FIVE;
                when "0110" => seg <= SIX;
                when "0111" => seg <= SEVEN;
                when "1000" => seg <= EIGHT;
                when "1001" => seg <= NINE;
                when others => seg <= (others => '0');
            end case;
                
        when others => seg <= (others => '0');
    end case;
    
end process;   
        
        
        
end Behavioral;
