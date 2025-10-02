describe('bibliography page', () => {
    beforeEach('should load', () => {
        cy.visit('literaturverzeichnis.html')
    })

    it('should display one table', () => {
        cy.get('caption')
        .should('be.visible')
        .should('have.length', 2)
    })
    
    it('should only have 2 columns', () => {
        cy.get('thead > tr >th')
        .should('be.visible')
        .should('have.length', 4)
    })

    
    it('should have an entry for id chbsg000050069', () => {
        cy.get('tr#chbsg000050069')
        .contains('Loetz 2022')
    })
    
    it('should have an entry for id chbsg991001261448103977', () => {
        cy.get('tr#chbsg991001261448103977')
        .contains('Loetz 2002')
    })
})

