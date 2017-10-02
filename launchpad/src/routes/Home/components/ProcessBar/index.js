import React from 'react';
import { Text, View, ScrollView, TouchableOpacity, StyleSheet, Image } from 'react-native';
import Svg,{
    Circle,
    Ellipse,
    G,
    LinearGradient,
    RadialGradient,
    Line,
    Path,
    Polygon,
    Polyline,
    Rect,
    Symbol,
    Use,
    Defs,
    Stop
} from 'react-native-svg';
const pinkIMG = require('../../../../assets/img/Grid/pink.png');

export const ProcessBar = ({ song, setSelected, selected }) => {

  return (
    <View style={{ flex: 1 }}>
      <ScrollView
        contentContainerStyle={styles.contentContainer}
        automaticallyAdjustContentInsets={false}
        horizontal={true}
        ref={ref => this.scrollView = ref}
        onContentSizeChange={(contentWidth, contentHeight)=>{        
          this.scrollView.scrollToEnd({ animated: true });
        }}
      >
      {song.map((e, i) => {
        const random = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
        const x = e.notes.indexOf('rest') === -1 ? 15 : 11;
        return  <TouchableOpacity key={i} onPress={() => setSelected(i)}>
                <Svg height="150" width="55">
                  <Text style={{ color: 'white', left: x, top: 20 }}>{e.notes} </Text>
                  {() => {
                      if (selected) {
                        console.log('sssss')
                        return (
                          <Rect x="0" y="0" width="50" stroke='#f5ff77' height="70" strokeWidth="5" fill={random}>
                          </Rect>
                        );
                      } else {
                        return (
                          <Rect x="0" y="0" width="50" height="70" strokeWidth="5" fill={random}>
                          </Rect>
                        );
                      }
                    }
                  }
                </Svg>
                </TouchableOpacity>;
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
