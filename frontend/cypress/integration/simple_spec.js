describe('Kitchen Sink', function () {
  it('.should() - assert that <title> is correct', function () {
    cy.visit('localhost:5000')
    cy.title().should('include', 'JWT Example')
  })
})
