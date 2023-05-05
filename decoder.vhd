----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 12:16:07 PM
-- Design Name: 
-- Module Name: decoder - Behavioral
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

entity decoder is
    Port ( clk : in STD_LOGIC;
           row : in std_logic_vector (3 downto 0);
           col : out std_logic_vector (3 downto 0);
           dec_out : out std_logic_vector (3 downto 0));
end decoder;

architecture Behavioral of decoder is
constant LAG : integer := 10;
signal scan_timer : std_logic_vector (19 downto 0) :=  (others => '0'); 
signal col_select : std_logic_vector (1 downto 0) :=  (others => '0'); 
begin
    process(clk)
        begin
            if rising_edge(clk) then
                if unsigned (scan_timer) = 99999 then  
                    scan_timer <= (others =>'0');
                    col_select <= std_logic_vector(unsigned (col_select) +1);
                else
                    scan_timer <=  std_logic_vector(unsigned (scan_timer ) +1);
                end if;
           end if;     
        end process ;      
          
process(clk)
begin
  if (rising_edge(clk)) then
    case col_select is
      when "00" =>
        col <= "0111";
        if (unsigned (scan_timer) = LAG) then
          case row is
            when "0111" => dec_out <= "0001";
            when "1011" => dec_out <= "0100";
            when "1101" => dec_out <= "0111";
            when "1110" => dec_out <= "0000";
            when others => null;
          end case;
        end if;
    
    
    when "01" =>
        col <= "1011";
        if (unsigned (scan_timer) = LAG) then
          case row is
            when "0111" => dec_out <= "0010";
            when "1011" => dec_out <= "0101";
            when "1101" => dec_out <= "1000";
            when "1110" => dec_out <= "1111";
            when others => null;
          end case;
        end if;
 
    
    
    
    when "10" =>
        col <= "1101";
        if (unsigned (scan_timer) = LAG) then
          case row is
            when "0111" => dec_out <= "0011";
            when "1011" => dec_out <= "0110";
            when "1101" => dec_out <= "1001";
            when "1110" => dec_out <= "1110";
            when others => null;
          end case;
        end if;
  
    
    
    
    when "11" =>
        col <= "1110";
        if (unsigned (scan_timer) = LAG) then
          case row is
            when "0111" => dec_out <= "1010";
            when "1011" => dec_out <= "1011";
            when "1101" => dec_out <= "1100";
            when "1110" => dec_out <= "1101";
            when others => null;
          end case;
        end if;
 
  end case;
  end if;
end process;

                                          
end Behavioral;
