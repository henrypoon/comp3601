import React from 'react';
import {
  View,
  StyleSheet,
  Image
} from 'react-native';

import {
  RkButton,
  RkText,
  RkCard,
  RkTheme
} from 'react-native-ui-kitten';

import Icon from 'react-native-vector-icons/FontAwesome';
import { ImageIcon } from '../imageIcon';


export const ListDetails = ({ song }) => {
  const likeStyle = [styles.buttonIcon, { color: RkTheme.colors.accent }];
  const iconButton = [styles.buttonIcon, { color: RkTheme.current.colors.text.hint }];
  return (
    <RkCard rkType='shadowed'>
      <View>
        <Image rkCardImg source={require('../../img/post4.png')} />
        <View rkCardImgOverlay style={styles.overlay}>
          <RkText rkType='header xxlarge' style={{ color: 'white' }}>{song.name}</RkText>
        </View>
      </View>
      <RkButton rkType='circle accent-bg' style={styles.floating}>
        <ImageIcon name='plus' />
      </RkButton>

      <View rkCardHeader style={{ paddingBottom: 2.5 }}>
        <View>

          <RkText rkType='subtitle'>Length: {song.length}</RkText>
        </View>
      </View>
      <View rkCardContent>
        <RkText rkType='compactCardText'>{song.description}</RkText>
      </View>
      <View rkCardFooter>
        <RkButton rkType='clear link'>
          <Icon name="heart" style={likeStyle} />
          <RkText rkType='accent'>Edit</RkText>
        </RkButton>
        <RkButton rkType='clear link'>
          <Icon name="send" style={iconButton} />
          <RkText rkType='hint'>Remove</RkText>
        </RkButton>
      </View >
    </RkCard>
  );
};

const styles = StyleSheet.create({
  screen: {
    backgroundColor: '#f0f1f5',
    padding: 12
  },
  buttonIcon: {
    marginRight: 7,
    fontSize: 19.7,
  },
  footer: {
    marginHorizontal: 16
  },
  avatar: {
    width: 42,
    height: 42,
    borderRadius: 21,
    marginRight: 17
  },
  dot: {
    fontSize: 6.5,
    color: '#0000008e',
    marginLeft: 2.5,
    marginVertical: 10,
  },
  floating: {
    width: 56,
    height: 56,
    position: 'absolute',
    zIndex: 200,
    right: 16,
    top: 173,
  },
  footerButtons: {
    flexDirection: 'row'
  },
  overlay: {
    justifyContent: 'flex-end',
    paddingVertical: 23,
    paddingHorizontal: 16
  }
});

export default ListDetails;
