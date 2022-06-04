import {createStackNavigator} from '@react-navigation/stack';
import React from 'react';
import {forSlide} from '../utils/interpolators';
import Home from '../screens/default/Home';

const DefaultStack = () => {
  const Stack = createStackNavigator<DefaultSPL>();

  return (
    <Stack.Navigator
      screenOptions={{
        headerShown: false,
        cardStyleInterpolator: forSlide,
        presentation: 'transparentModal',
      }}>
      <Stack.Screen name="Home" component={Home} />
    </Stack.Navigator>
  );
};

export default DefaultStack;
