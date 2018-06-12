import gql from 'graphql-tag'

export default (context, apolloClient) => (
  apolloClient.query({
    query: gql`
      query greeting {
        greeting {
          message
        }
      }
    `
  }).then(({ data }) => {
    return { greeting: data }
  }).catch(() => {
    // Fail gracefully
    return { greeting: "no greeting" }
  })
)
