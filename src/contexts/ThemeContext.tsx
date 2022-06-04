import React from "react";
import { darkTheme } from "../misc/themes";

type ThemeContext = {
  theme: AppTheme;
  switchTheme: () => void;
};

export const ThemeContext = React.createContext<ThemeContext>({
  theme: darkTheme,
  switchTheme: () => {},
});

export const ThemeProvider = ThemeContext.Provider;
