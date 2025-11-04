*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_zr_tflight_ca DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrTflightCa
        RESULT result.

    METHODS validate_currency
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR Zrtflightca~validate_currency.




ENDCLASS.

CLASS lhc_zr_tflight_ca IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validate_currency.

    " Traer datos que necesito validar
    READ ENTITY zr_tflight_ca
      FIELDS ( CurrencyCode price )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_flight).

    LOOP AT lt_flight INTO DATA(ls_flight).

      " Validar moneda usando CDS I_Currency
*      SELECT SINGLE Currency
*       FROM I_Currency
*        WHERE Currency = @ls_flight-CurrencyCode
*        INTO @DATA(lv_currency).
*
*      IF sy-subrc <> 0.
*        APPEND VALUE #(
*          %tky = ls_flight-%tky
*          %msg = new_message_with_text(
*                    severity = if_abap_behv_message=>severity-error
*                    text     = |Currency { ls_flight-CurrencyCode } invalid.| ) )
*        TO reported-zrtflightca.
*      ENDIF.

      " Validar precio > 0
      IF ls_flight-price <= 0.
        APPEND VALUE #(
          %tky = ls_flight-%tky
*          %msg = new_message(
*              id       = 'ZMSG_XXXX'
*              number   = '001'
*              severity = if_abap_behv_message=>severity-error
*              v1       = '' ) )
          %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text     = |Price must be greater than zero.| ) )
        TO reported-zrtflightca.
      ENDIF.





    ENDLOOP.

  ENDMETHOD.


ENDCLASS.
