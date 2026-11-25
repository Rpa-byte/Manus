*** Variables ***
# Write xpaths WITHOUT the "xpath=" prefix, the keywords add it.

# --- Page factures : filtre ---
${SAGE_FACTURE_FILTRE_NUMERO_PIECE}     /html/body/div/article/div[1]/div/article/div[1]/div[2]/div[1]/div/article/div[2]/div/div/div/div[1]/table/tr[2]/td[1]/div/input

# --- Page factures : liste des résultats ---
${SAGE_FACTURE_PREMIERE_LIGNE}          REPLACE_WITH_FIRST_ROW_XPATH

# --- Page factures : actions ---
${SAGE_FACTURE_BOUTON_IMPRIMER}         /html/body/div/article/div[1]/div/article/div[2]/header/div[1]/div/div[4]/div/div[2]/div[2]/a