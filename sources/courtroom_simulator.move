/*
/// Module: courtroom_simulator
module courtroom_simulator::courtroom_simulator;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


module courtroom_simulator::courtroom_simulator_token{
    use std::option;
    use sui::coin;
    use sui::coin::TreasuryCap;
    use sui::transfer::{public_transfer, public_freeze_object};
    use sui::tx_context::TxContext;

    public struct COURTROOM_SIMULATOR_TOKEN has drop{}

    fun init(witness:COURTROOM_SIMULATOR_TOKEN,ctx: &mut TxContext) {
        let (treasuryCap,denyCap,metadata)=coin::create_regulated_currency(
            witness,
            8,
            b"CS",
            b"CS Coin",
            b"coin published by Courtroom Simulator",
            option::none(),
            ctx
        );
        public_transfer(treasuryCap,ctx.sender());
        public_transfer(denyCap,ctx.sender());
        public_freeze_object(metadata);
    }
    
    public fun mint(cap: &mut TreasuryCap<COURTROOM_SIMULATOR_TOKEN>, amount:u64, recipient:address, ctx:&mut TxContext){
        let coin=coin::mint(cap,amount,ctx);
        public_transfer(coin,recipient);
    }
}