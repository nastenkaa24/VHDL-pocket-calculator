library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity impartitor_8bit is
port (
    A        : in  std_logic_vector(7 downto 0);
    B        : in  std_logic_vector(7 downto 0);
    Rezultat : out std_logic_vector(15 downto 0)
);
end impartitor_8bit;

architecture Behavioral of impartitor_8bit is
  signal p0,p1,p2,p3,p4,p5,p6,p7,cat,rest,c: std_logic_vector(0 to 15);	
-- semnale pentru shift la stanga pe rand
begin	  
p7(8 to 15)<=b;	   --p7 nu va fi shiftat
P7(0 to 7)<="00000000";-- restul e 0. 16 biti ca sa nu se piarda valoarea lui b
p6<=p7+p7; -- p6 shift o data
p5<=p6+p6;	-- de 2 ori
p4<=p5+p5; -- 3 ori
p3<=p4+p4;	-- 4 ori
p2<=p3+p3;	 -- 5 ori
p1<=p2+p2; -- shl 6 ori
p0<=p1+p1; -- shl 7 ori	

process(p0,p1,p2,p3,p4,p5,p6,p7)
variable r,c,p:std_logic_vector(0 to 15);
begin 
	r(8 to 15):=a;-- restul final va fi ce ramane dupa ce scad b din el
	r(0 to 7):="00000000";
	c:="0000000000000000";-- catul e de la 0
	if( p0>"00000000" and r>=p0) then-- cea mai mare shiftare 
		r:=r-p0;-- daca e mai mica, scad din rest permutarea respectiva
		c:=c+128;-- adun 2^7 la cat conform algoritmului din documentatie
	end if;	
	if( p1>"00000000"and r>=p1) then-- shiftare left de 6 ori, daca restul e mai mare decat shift de 6 ori
		r:=r-p1;
		c:=c+64;-- adun 2 la nr de shift, adica 2^6
	end if;
	if(p2>"00000000"and r>=p2) then -- la fel pentru fiecare shl
		r:=r-p2;
		c:=c+32; -- 2^5 ,p2  e shl de 5 ori
	end if;
	if( p3>"00000000"and r>=p3) then --etc
		r:=r-p3;
		c:=c+16;
	end if;
	if(p4>"00000000"and r>=p4) then
		r:=r-p4;
		c:=c+8;
	end if;
	if(p5>"00000000"and r>=p5) then
		r:=r-p5;
		c:=c+4;
	end if;	   
	if( p6>"00000000"and r>=p6) then
		r:=r-p6;
		c:=c+2;	 
	end if;
	if( p7>"00000000"and r>=p7) then-- acelasi lucru pana aici
		r:=r-p7;
		c:=c+1;
	end if;
	cat<=c;-- sumele de puteri ale 2  reprezinta catul
	rest<=r;-- restul e ce ramane dupa scadere
end process;
	
--process(a,b)
--begin
--    if a = x"00" or b = x"00" then 
--        cat<= x"0000";	
--        rest<= x"0000";	
--    end if;
--end process;
		 
Rezultat<= cat(8 TO 15) & rest(8 to 15);
		 
end Behavioral;