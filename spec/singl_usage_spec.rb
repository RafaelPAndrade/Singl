# frozen_string_literal: true

RSpec.describe Singl do
  context "in simple inline calls" do
    before { Singl.ify! Integer }

    it "works" do
      expect(Integer.odd?(42)).to eq(42.odd?)
      expect(Singl.odd?(42)).to eq(42.odd?)
    end
  end

  context "when using in case expressions" do
    context "with no preparation" do
      it "works in arbitrary methods" do
        expect((
          case 42
          when Singl.even? then :works
          when Singl.odd? then :wat
          else raise Error
          end
        )).to eq(:works)
      end

      it "raises NoMethodError if it doesn't respond to the method" do
        expect do
          (
         case :foo
         when Singl.even? then :works
         when Singl.odd? then :wat
         else raise Error
         end
       )
        end.to raise_error(NoMethodError)
      end
    end

    context "in Singlified classes" do
      before { Singl.ify! Integer }

      it "works to discriminate even/odd numbers" do
        expect((
          case 42
          when Integer.even? then :works
          when Integer.odd? then :wat
          else raise Error
          end
        )).to eq(:works)
      end

      it "raises TypeError on mismatched type" do
        expect do
          (
         case :foo
         when Integer.even? then :works
         when Integer.odd? then :wat
         else raise Error
         end
       )
        end.to raise_error(TypeError)
      end
    end
  end
end
