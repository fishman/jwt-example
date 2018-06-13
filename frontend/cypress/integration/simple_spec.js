describe('Kitchen Sink', function () {
  it('.should() - assert that <title> is correct', function () {
    cy.visit('localhost:8080')
    cy.title().should('include', 'JWT Example')
  })

  it('.should() - login', function () {
    cy.visit('localhost:8080')
    cy.title().should('include', 'signin')
    cy.get('[name="email"]')
      .invoke('val', 'test@test.com')
      .trigger('change')

    cy.get('[type="password"]')
      .invoke('val', '123456')
      .trigger('change')

    cy.get('button').click()
  })
})
