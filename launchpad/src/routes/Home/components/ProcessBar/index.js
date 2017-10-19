import React from 'react';
import { Text, View, ScrollView, TouchableOpacity, StyleSheet, Image } from 'react-native';
import { Rect, Svg } from 'react-native-svg';

export const ProcessBar = ({ song, setSelected, selected }) => {
  const displayRect = (i, random) => {
    if (i === selected) {
      return (
        <Rect x="0" y="0" width="50" stroke='#ff0a3b' height="50" strokeWidth="5" fill={random} />
      );
    } else {
      return (
        <Rect x="0" y="0" width="50" height="50" strokeWidth="5" fill={random} /> 
      );
    }
  };


  return (
    <View style={{ flex: 1 }}>
      <ScrollView
        contentContainerStyle={styles.contentContainer}
        automaticallyAdjustContentInsets={false}
        horizontal={true}
        ref={ref => this.scrollView = ref}
        onContentSizeChange={(contentWidth, contentHeight) => {        
          this.scrollView.scrollToEnd({ animated: true });
        }}
      >
      {song.map((e, i) => {
        const random = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
        const stroke = i === selected ? '#ff0a3b' : '';
        const x = e.notes.indexOf('rest') === -1 ? 15 : 11;
        return  <TouchableOpacity key={i} onPress={() => setSelected(i)}>
                  <Svg height="70" width="55">
                    <Text style={{ color: 'white', left: x, top: 7 }}>{e.notes} </Text>
                    <Text style={{ color: 'white', left: x, top: 15 }}>{e.duration} </Text>
                    {displayRect(i, random)}
                  </Svg>
                </TouchableOpacity>
      })}
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  contentContainer: {
    paddingVertical: 0,
  }
});

export default ProcessBar;