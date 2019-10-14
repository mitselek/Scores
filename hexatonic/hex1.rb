STEP = 2 ** (1.0 / 16)

def hx2midi(hnote)
  #puts step
  #puts "Note:", hnote, hnote.to_s(16).rjust(2, '0')
  hvalue = 27.5 * (STEP ** hnote)
  mvalue = hz_to_midi hvalue
  #puts "H:", hvalue, "M:", mvalue
  return mvalue
end

def play_legato_note(note_value, duration)
  release_duration = duration
  if duration < 1
    release_duration = 1
  end
  play hx2midi(note_value), release: release_duration, amp: 0.65
end

def arp(chord)
  chord.each do |d|
    play_legato_note(d, 2)
    sleep 0.5
  end
end

def arpr(chord)
  chord.ring.reflect.each do |d|
    play_legato_note(d, 2)
    sleep 0.5
  end
end

def transpose(note, interval)
  return note * (STEP ** interval)
end

def chrd(root, harmonics, dur, int)
  note = root
  harmonics.unshift(0).each do |p|
    note = note + p
    play_legato_note(note, dur)
    sleep int
  end
end
