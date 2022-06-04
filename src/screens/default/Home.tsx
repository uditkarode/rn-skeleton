import React from 'react';

import {StackScreenProps} from '@react-navigation/stack';
import {ThemeContext} from '../../contexts/ThemeContext';
import {View} from 'react-native';
import {getCommonStyles} from '../../misc/common-styles';

type Props = StackScreenProps<DefaultSPL, 'Home'>;

export default function Default(_navProps: Props) {
  let {theme} = React.useContext(ThemeContext);
  const styles = getCommonStyles(theme);

  return (
    <View style={styles.root}>
      <View style={styles.debugStyle} />
    </View>
  );
}
