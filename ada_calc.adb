with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Indefinite_Hashed_Maps;

procedure Calculator is
   type Var_Map is new Ada.Containers.Indefinite_Hashed_Maps.Map
     (Key_Type => Unbounded_String, Element_Type => Float);

   package VarTable is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type => Unbounded_String, Element_Type => Float);

   use VarTable;
   Table : Var_Map;

   function To_Unbounded(S : String) return Unbounded_String is
   begin
      return To_Unbounded_String(S);
   end;

   -- Placeholder eval, needs external or internal arithmetic logic
   function Eval(Expr : String) return Float is
   begin
      return 0.0;
   end;

   Line : String (1 .. 256);
   Last : Natural;

begin
   loop
      Put("> ");
      Get_Line(Line, Last);
      declare
         Input : constant String := Line(1 .. Last);
      begin
         if Input = "exit" or else Input = "quit" then
            exit;
         else
            Put_Line("Evaluation not implemented in this stub.");
         end if;
      end;
   end loop;
end Calculator;

