import { Mutation, withApollo } from 'react-apollo'
import gql from 'graphql-tag'
import cookie from 'cookie'
import redirect from '../lib/redirect'

const CREATE_USER = gql`
mutation signUp($name: String, $email: String, $password: String, $password_confirmation: String) {
  signUp(input: { name: $name, email: $email, password: $password, password_confirmation: $password_confirmation }) {
    currentUser: user {
      id
      name
      email
    }
    token
    messages {
      field
      message
    }
  }
}
`

const RegisterBox = (props) => {
  let name, email, password

  return (
    <Mutation mutation={CREATE_USER} onCompleted={(data) => {
      // Store the token in cookie
      document.cookie = cookie.serialize('token', data.signUp.token, {
        maxAge: 30 * 60 // 30 minutes
      })
      // Force a reload of all the current queries now that the user is
      // logged in
      props.client.resetStore().then(() => {
        redirect({}, '/')
      })
    }} onError={(error) => {
      // If you want to send error to external service?
      console.log(error)
    }}>
      {(create, { data, error }) => (
        <div>
          <form onSubmit={e => {
            e.preventDefault()
            e.stopPropagation()

            create({ variables: {
              name: name.value,
              email: email.value,
              password: password.value
            }})

            name.value = email.value = password.value = ''
          }}>
            { error && <p>Issue occured while registering :(</p> }
            <input name='name' placeholder='Name' ref={node => { name = node }} /><br />
            <input name='email' placeholder='Email' ref={node => { email = node }} /><br />
            <input name='password' placeholder='Password' ref={node => { password = node }} type='password' /><br />
            <button>Register</button>
          </form>
        </div>
      )}

    </Mutation>
  )
}

export default withApollo(RegisterBox)
