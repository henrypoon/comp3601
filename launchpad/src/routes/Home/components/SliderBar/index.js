import React from 'react';
import { Text, Slider, View } from 'react-native';

export const SliderBar = ({ setSlider, value, min, max }) => {

  return (
    <View style={{ flexDirection: 'row' }}>
      <Text style={{ color: 'white', paddingVertical: 10 }}>{value}  </Text>
      <Slider
       style={{ width: 300 }}
       minimumValue={min}
       maximumValue={max}
       step={1}
       value={value}
       onValueChange={val => setSlider(val)}
      />
    </View>
  );
};

export default SliderBar;
