library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity my_fsm is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           s : out std_logic_vector(1 downto 0)
           );
end my_fsm;

architecture Behavioral of my_fsm is
signal b : integer := 0;
signal cn : integer := 0;
signal sw : integer := 0;
signal r : integer := 0; 
signal a : integer := 0;
signal n : integer := 0;
signal m : integer := 0;
signal fin : integer := 0;
signal k : integer := 0;
signal ag : integer := 0;


begin
    process(clk)
        begin
            if rising_edge(clk) then
                if rst = '1' then
                    b <= 0;
                    cn <= 0;
                    sw <= 0;
                    r <= 0;
                    a <= 0;
                    n <= 0;
                    m <= 0;
                    fin <= 0;
                    k <= 0;
                    ag <= 0;
                    
                elsif en = '1' then
                    if b = 0 then 
                        if cn < 2 then
                            cn <= cn + 1;
                            b <= 0;
                        end if;
                        
                        if (cn = 2) and (sw < 2) then
                            b <=  1;
                            if (a = 2) then
                                fin <= fin + 1;
                            end if;
                        end if;
                        
                        if (sw = 2) and (r = 0) then
                            b <= 2;
                            r <= 1;
                        end if;
                        
                        if (cn = 2) and (sw = 2) and (r = 1) and (n = 1) then 
                            b <= 1;
                            sw <= 1;
                            n <= 0;
                        end if;
                        
                        if (cn = 2) and (sw = 2) and (r = 1) and (a = 0) and (n = 0) then 
    
                            if k = 0 then
                                cn <= cn - 1;
                                a <= 1;
                            else
                                a <= 2;
                                cn <= cn;
                            end if;
                            --b <= 0;
                        end if;
                        
                        if (cn = 2) and (sw = 2) and (r = 1) and (a = 1) then
                            b <= 3;
                        end if;
                        
                        if (cn = 2) and (sw = 2) and (r = 1) and (m = 1) and (fin = 0) and (a = 2) then
                            sw <= 0;
                            b <= 1;
                        end if;
                        
                        if fin = 1 then
                            b <= 2;
                        end if;
                        
                    end if;
                    
                    if b = 1 then 
                        if sw <= 1 then
                            sw <= sw + 1;
                            b <= 0;
                        end if;  
                        if m = 1 then 
                            fin <= fin + 1;
                        end if;
                    end if;
                    
                    if b = 2 then
                        if (fin /= 0) then
                            ag <= ag + 1;
                            b <= 2;
                            if (ag = 3) then
                                b <= 0;
                                cn <= 0;
                                sw <= 0;
                                r <= 0;
                                a <= 0;
                                n <= 0;
                                m <= 0;
                                fin <= 0;
                                k <= 0;
                                ag <= 0;
                            end if;
                        else
                            cn <= 0;
                            sw <= 0;
                            n <= 1;
                            b <= 0;
                            end if;
                    end if;    
                    
                    if b = 3 then
                        b <= 0;
                        if m = 0 then
                            cn <= 0;
                            m <= 1;
                        else
                            a <= 0;
                            k <= 1;
                        end if;  
                    end if;  
                    
                else
                    b <= b;
                    cn <= cn;
                    sw <= sw;
                    r <= r;
                    a <= a;
                    n <= n;
                    m <= m;
                    fin <= fin;
                    k <= k;
                    ag <= ag;
                end if;
            end if;
            
            case b is
                when 0 =>
                    s <= "01";
                when 1 =>
                    s <= "10";
                when 3 =>
                    s <= "11";
                when others =>
                    s <= "00";
            end case;
    end process;                
                
                    
                

end Behavioral;
