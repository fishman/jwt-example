import React from 'react';
import App from 'next/app';
import 'semantic-ui-css/semantic.css';
import 'semantic-ui-css/themes/default/assets/fonts/icons.eot';
import 'semantic-ui-css/themes/default/assets/fonts/icons.woff';
import 'semantic-ui-css/themes/default/assets/fonts/icons.woff2';
import {
  Container,
  Segment,
  Grid,
  CustomMessage,
  Navbar,
  Menu,
  Dropdown,
  Header,
  Button,
  List,
  Icon
} from 'semantic-ui-react';
import Head from 'next/head';

class Layout extends React.Component {
  render () {
    const {children} = this.props;
    return <Container text style={{ marginTop: '7em' }}>
      {children}
    </Container>;
  }
}

export default class MyApp extends App {
  render () {
    const {Component, pageProps} = this.props;
    return <div>
      <Head>
        <link rel='stylesheet' href='/_next/static/style.css' />
      </Head>
      <Menu fixed='top' inverted>
        <Container>
          <Menu.Item as='a' header>JWT Example</Menu.Item>
          <Menu.Item as='a'>Home</Menu.Item>
        </Container>
      </Menu>
      <Layout>
        <Component {...pageProps} />
      </Layout>
      </div>;
  }
}
