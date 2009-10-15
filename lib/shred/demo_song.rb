# The Concept here is to be able to have a scale libary that can easly be used to change scales in a live envoriment 
# Needs to have the scale.rb file in the lib folder this is currently just fancy sudo code of how 
# id like to start stucturing things 


# Also Looking to create ruby based math for generating the tones number and chuck to play it

example 






require 'scales'
module Chuckr
 module Shreds
  class Song < Shred
    
    def setup
      set :loop => true, :time => 100, :gain => 0.2, :mix_by => 0.1, :pattern => major
      set :pattern => major

      setup_ck do
        %{
          SinOsc s => JCRev r => dac;
          #{self[:gain]} => s.gain;
          #{self[:mix_by]} => r.mix;
          [ #{self[:pattern].collect {|u| u.to_i}.join(", ")} ] @=> int pattern[];
        }
      end


# in theory it be nice to be able to just scale[rand(scale.size)] and it randomizes through a given scale
      process_ck do
        %{
        
          Std.mtof( major[rand(major.size)] ) => s.freq;
          #{self[:time]}::ms => now;
        }
      end
    end
 
  end
 end
end
