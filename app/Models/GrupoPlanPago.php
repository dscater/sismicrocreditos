<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GrupoPlanPago extends Model
{
    use HasFactory;

    protected $fillable = [
        "grupo_id",
        "nro_cuota",
        "saldo_inicial",
        "capital",
        "interes",
        "saldo",
        "cuota",
        "cancelado",
        "fecha_pago",
    ];

    protected $appends = ["fecha_pago_t", "dias_mora_t", "monto_mora_t"];

    public function getDiasMoraTAttribute()
    {
        $dias_mora = 0;
        if ($this->cancelado == 'NO') {
            // VERIFICAR LOS DÍAS DE MORA
            $fecha_actual = date("Y-m-d");
            $fecha_pago = $this->fecha_pago;
            // Obtener los días transcurridos
            $dias_mora = PrestamoController::obtenerDiferenciaDias($fecha_actual, $fecha_pago);
        }
        return $dias_mora;
    }

    public function getMontoMoraTAttribute()
    {
        $monto_mora = 0;
        if ($this->cancelado == 'NO') {
            // VERIFICAR LOS DÍAS DE MORA
            $fecha_actual = date("Y-m-d");
            $fecha_pago = $this->fecha_pago;
            // Obtener los días transcurridos
            $dias_mora = PrestamoController::obtenerDiferenciaDias($fecha_actual, $fecha_pago);
            if ($dias_mora > 0) {
                $monto_mora = (($this->grupo->monto / 100) * 0.3) * $dias_mora;
                $monto_mora = round($monto_mora, 2);
            }
        }

        return $monto_mora;
    }

    public function getFechaPagoTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_pago));
    }


    public function grupo()
    {
        return $this->belongsTo(Grupo::class, 'grupo_id');
    }
}
