import React from 'react';
import { Text, Slider, View } from 'react-native';

export const SliderBar = ({ setSlider, value, min, max }) => {

  return (
    <View>
      <Slider
       style={{ width: 300 }}
       minimumValue={min}
       maximumValue={max}
       step={1}
       value={value}
       onValueChange={val => setSlider(val)}
      />
      <Text style={{ color: 'white' }}>{value}</Text>
    </View>
  );
};

export default SliderBar;
