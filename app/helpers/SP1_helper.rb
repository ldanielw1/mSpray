require 'pdf_helper'

module Sp1Helper

#records the number of rooms sprayed
def setSprayedRooms(roomsSprayed)
  checkBoxes(:sprayedRooms, roomsSprayed)
  setField(:sprayedRooms, sheltersSprayed)
end

#records the number of shelters sprayed
def setSprayedShelters(sheltersSprayed)
  checkBoxes(:sprayedShelters, sheltersSprayed)
  setField(:sprayedShelters, sheltersSprayed)
end

  #records the number of unsprayed rooms
  def setUnsprayedRooms(roomsUnsprayed)
    checkBoxes(:unsprayedRooms, roomsUnsprayed)
    setField(:unsprayedRooms, roomsUnsprayed)
  end

  #records the chemical used for the spraying
  def setChemical(chemical)
    uncheckField(:ddtUsed)
    uncheckField(:baythroidUsed)
    uncheckField(:kothrineUsed)
    if chemical.upper == "DDT"
      checkField(:ddtUsed)
    elsif
      checkField(:kothrineUsed)
    end
  end

  #records the name of the sprayer
  def setSprayer(sprayer)
    setField(:sprayman, sprayer)
  end

  #records teh name of the foreman
  def setForeman(foreman)
    setField(:foreman, foreman)
  end

  #records the officer name
  def setFieldOfficer(officer)
    setField(:fieldOfficer, officer)
  end

  #records the district name
  def setDistrict(district)
    setField(:district, district)
  end

  #recording the locality of spraying
  def setLocality(locality)
    setField(:locality, locality)
  end
  
  #records the date of spraying
  def setDate(date)
    setField(:date, date)
  end

  #records all data related to a spraying
  def setData(sprayData)
    setSprayedRooms(sprayData.rooms_sprayed)
    setSprayedShelters(sprayData.shelters_sprayed)
    setUnsprayedRooms(sprayData.unsprayed_rooms)
    setCanRefills(sprayData.refilled)
  end

  #checks off a number of boxes in a row
  def checkBoxes(genericField, boxes)
    for i in 1..boxes
      checkField(genericField.to_s + i)
  end

end
