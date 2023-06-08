/*===============================================================================
Copyright (c) 2023 PTC Inc. and/or Its Subsidiary Companies. All Rights Reserved.

Vuforia is a trademark of PTC Inc., registered in the United States and other
countries.
===============================================================================*/

#ifndef _VU_PLATFORMCONTROLLER_IOS_H_
#define _VU_PLATFORMCONTROLLER_IOS_H_

/**
 * \file PlatformController_iOS.h
 * \brief iOS-specific functionality for the Vuforia Engine
 */

#include <VuforiaEngine/Core/Core.h>

#ifdef __cplusplus
extern "C"
{
#endif

/** \addtogroup PlatformIOSControllerGroup iOS-specific Platform Controller
 * \ingroup PlatformControllerGroup
 * \{
 * iOS platform-specific platform functionality accessed via the PlatformController
 */

/// \brief ARKit-specific info for the platform-based Vuforia Fusion Provider
/**
 * \note The pointers contained in this data structure are owned by Vuforia Engine and should
 * be used with caution by the developer. For example do not release the session, do not pause
 * the session, do not reconfigure it, doing so will cause Vuforia Engine's handling of the information
 * from the provider to fail in undefined ways.
 *
 * A valid value for the session will be available after Vuforia Engine has been started and it
 * will remain valid until Vuforia Engine is stopped.
 *
 * A valid value for the frame will be available after Vuforia Engine has been started and the
 * Vuforia State contains camera frame data. The value for the frame is valid only for the duration
 * of one frame, thus the caller needs to request the information for every new frame.
 */
typedef struct VuPlatformARKitInfo
{
    /// \brief ARKit session, pointer of type "ARSession"
    /**
     * The caller needs to cast the arSession pointer to the appropriate type as follows:
     * ARSession* session = (__bridge ARSession*)info.arSession;
     */
    void* arSession;

    /// \brief ARKit frame, pointer of type "ARFrame"
    /**
     * The caller needs to cast the arFrame pointer to the appropriate type as follows:
     * ARFrame* frame = (__bridge ARFrame*)info.arFrame;
     *
     * Alternatively the frame can also be obtained directly from the ARSession,
     * using arSession.currentFrame;
     */
    void* arFrame;
} VuPlatformARKitInfo;

/// \brief Get information about the ARKit Fusion Provider Platform
/**
 * The information contained in the returned struct can be used to allow applications to interact with
 * the underlying ARKit session to gain access to functionality not currently available through the
 * Vuforia API. For example additional lighting information or plane boundaries.
 *
 * \note Call this function after Vuforia Engine has been started and the Vuforia State
 * contains a camera frame.
 *
 * \param controller Plaform controller retrieved from Engine (see vuEngineGetPlatformController)
 * \param arkitInfo ARKit-specific info for the platform-based Vuforia Fusion Provider
 * \returns VU_FAILED if Vuforia is not running with the ARKit Fusion Provider Platform, VU_SUCCESS otherwise
 */
VU_API VuResult VU_API_CALL vuPlatformControllerGetARKitInfo(const VuController* controller, VuPlatformARKitInfo* arkitInfo);

/// \brief Set ARKit platform fusion provider configuration
/**
 * This function is used to configure the ARKit session that will be used. An instance of the class
 * ARWorldTrackingConfiguration should be created and its parameters should be set as desired.
 * The pointer to said instance should be passed into this function. Vuforia Engine then inspects the
 * configuration values and takes a copy of the ones that are appropriate to use with Vuforia Engine
 *
 * \note Call this function before vuPlatformControllerGetARKitInfo() is called for the first time.
 *
 * \note Important to notice that the setting has no effect until vuPlatformControllerGetARKitInfo() is called.
 *
 * \note Currently Vuforia Engine only uses the AREnvironmentTexturing option of the
 * ARWorldTrackingConfiguration instance supplied to this call. All other configuration options
 * are managed by Vuforia Engine.
 *
 * \note The current configuration can be found by acquiring the ARSession by using
 * vuPlatformControllerGetARKitInfo and querying the configuration from it.
 *
 * \param controller Platform controller retrieved from Engine (see vuEngineGetPlatformController)
 * \param config Configuration pointer of type ARWorldTrackingConfiguration
 */
VU_API VuResult VU_API_CALL vuPlatformControllerSetARKitConfig(VuController* controller, const void* config);

/** \} */

#ifdef __cplusplus
}
#endif

#endif // _VU_PLATFORMCONTROLLER_IOS_H_
