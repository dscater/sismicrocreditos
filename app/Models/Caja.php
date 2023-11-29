<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Caja extends Model
{
    use HasFactory;

    protected $fillable = [
        "caja",
        "saldo",
    ];

    public static function actualizaSaldos()
    {
        // Pagos por Cuotas
        $caja = Caja::find(1);
        $creditos = CajaMovimiento::where("caja_id", 1)->where("tipo", "CRÉDITO")->sum("monto");
        $debitos = CajaMovimiento::where("caja_id", 1)->where("tipo", "DEBITO")->sum("monto");
        $caja->saldo = (float)$creditos - (float)$debitos;
        $caja->save();
        // Gastos Administrativos
        $caja = Caja::find(2);
        $creditos = CajaMovimiento::where("caja_id", 2)->where("tipo", "CRÉDITO")->sum("monto");
        $debitos = CajaMovimiento::where("caja_id", 2)->where("tipo", "DEBITO")->sum("monto");
        $caja->saldo = (float)$creditos - (float)$debitos;
        $caja->save();
        // Cargos por Multa
        $caja = Caja::find(3);
        $creditos = CajaMovimiento::where("caja_id", 3)->where("tipo", "CRÉDITO")->sum("monto");
        $debitos = CajaMovimiento::where("caja_id", 3)->where("tipo", "DEBITO")->sum("monto");
        $caja->saldo = (float)$creditos - (float)$debitos;
        $caja->save();
        // Intereses
        $caja = Caja::find(4);
        $creditos = CajaMovimiento::where("caja_id", 4)->where("tipo", "CRÉDITO")->sum("monto");
        $debitos = CajaMovimiento::where("caja_id", 4)->where("tipo", "DEBITO")->sum("monto");
        $caja->saldo = (float)$creditos - (float)$debitos;
        $caja->save();
        return true;
    }

    public static function getSaldoTotal()
    {
        self::actualizaSaldos();
        $suma_saldo = 0;
        // Pagos por Cuotas
        $caja = Caja::find(1);
        $suma_saldo += (float)$caja->saldo;

        // Gastos Administrativos
        $caja = Caja::find(2);
        $suma_saldo += (float)$caja->saldo;

        // Cargos por Multa
        $caja = Caja::find(3);
        $suma_saldo += (float)$caja->saldo;

        // Intereses
        $caja = Caja::find(4);
        $suma_saldo += (float)$caja->saldo;

        return $suma_saldo;
    }
}
