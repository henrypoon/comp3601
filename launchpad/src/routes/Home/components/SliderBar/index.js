import React from 'react';
import { Text, View } from 'react-native';
import { Slider } from 'react-native-elements';

export const SliderBar = ({ setSlider, value, min, max }) => {

  return (
    <View style={{ flexDirection: 'row', flex: 0.5, alignItems: 'stretch', justifyContent: 'center' }}>
      <Text style={{ color: 'white', paddingVertical: 10 }}>
        {value}  
      </Text>
      <Slider
       style={{ width: 300 }}
       minimumValue={min}
       maximumValue={max}
       animateTransitions={true}
       step={1}
       value={value}
       onValueChange={val => setSlider(val)}
      />
    </View>
  );
};

export default SliderBar;
