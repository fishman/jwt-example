import gql from 'graphql-tag'

export default (context, apolloClient) => (
  apolloClient.query({
    query: gql`
      query currentUser {
        currentUser {
          id
          name
          email
        }
      }
    `
  }).then(({ data }) => {
    return { loggedInUser: data }
  }).catch(() => {
    // Fail gracefully
    return { loggedInUser: {} }
  })
)
