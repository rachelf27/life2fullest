// client/src/App.js

import Header from "./components/Header/Header";
import Footer from "./components/Footer/Footer";

const App = ({ children }) => (
  <>
    <Header />
    <main>{children}</main>
    <Footer />
  </>
);
export default App;
